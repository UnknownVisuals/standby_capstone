import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }

interface Notification {
  id: string
  temp?: number
  anomaly?: number
  anomaly_score?: number
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: Notification
  schema: 'public'
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json();

  const { data } = await supabase
    .from('profiles')
    .select('fcm_token')
    .neq('fcm_token', null);

  if (!data || data.length === 0) {
    return new Response(JSON.stringify({ error: "No FCM tokens found" }), { status: 404 });
  }

  const fcmTokens = data.map((row) => row.fcm_token);

  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key,
  });

  const messages = [];

  if (payload.record.temp !== undefined && payload.record.temp !== null) {
    if (payload.record.temp === 85.0) {
      messages.push({
        title: `🟢 DEVICE ON 🟢`,
        body: `Device is on and ready for real-time monitoring!`,
      });
    } else {
      messages.push({
        title: `⚠️ TEMPERATURE WARNING ⚠️`,
        body: `${payload.record.temp}°C is outside the suitable range for the incubator.`,
      });
    }
  }

  if (payload.record.anomaly !== undefined && payload.record.anomaly !== null) {
    messages.push({
      title: `⚠️ ANOMALY DETECTED ⚠️`,
      body: `Check your hardware device! Anomaly score: ${payload.record.anomaly_score}`,
    });
  }

  const results = await Promise.all(
    fcmTokens.map(async (token) => {
      const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${accessToken}`,
          },
          body: JSON.stringify({
            message: {
              token,
              notification: messages.length > 0 ? messages[0] : null,
            },
          }),
        }
      );
      return res.json();
    })
  );

  return new Response(JSON.stringify(results), {
    headers: { 'Content-Type': 'application/json' },
  });
});

const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}