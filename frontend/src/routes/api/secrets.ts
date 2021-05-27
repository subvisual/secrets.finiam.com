import Redis from 'ioredis';
import type { RequestHandler } from '@sveltejs/kit';
import crypto from "crypto";

const redis = new Redis(process.env["REDIS_URL"]);

export const post: RequestHandler = async ({ body }) => {
  const { secret } = JSON.parse(body as string);
  const room = crypto.randomUUID();

  await redis.set(room, secret);

  return { body: { room } };
};

const REDIS_SCRIPT = `
  local secret = redis.call('get', KEYS[1])
  --redis.call('del', KEYS[1])

  return secret
`;

export const get: RequestHandler = async ({ query }) => {
  const secret = await redis.eval(REDIS_SCRIPT, 1, query.get('id'));

  if (!secret) return { status: 404, body: '' };

  return { body: { secret } };
};
