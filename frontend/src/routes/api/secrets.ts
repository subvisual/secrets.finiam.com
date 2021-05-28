import Redis from 'ioredis';
import type { RequestHandler } from '@sveltejs/kit';
import { v4 as uuid } from 'uuid';

function buildRedisClient() {
  return new Redis(process.env['REDIS_URL']);
}

export const post: RequestHandler = async ({ body }) => {
  const { secret } = JSON.parse(body as string);
  const room = uuid();

  const redis = buildRedisClient();
  await redis.set(room, secret);
  await redis.expire(room, 3600);
  redis.disconnect();

  return { body: { room } };
};

const REDIS_SCRIPT = `
  local secret = redis.call('get', KEYS[1])
  redis.call('del', KEYS[1])

  return secret
`;

export const get: RequestHandler = async ({ query }) => {
  const redis = buildRedisClient();
  const secret = await redis.eval(REDIS_SCRIPT, 1, query.get('id'));
  redis.disconnect();

  if (!secret) return { status: 404, body: { error: 'not found' } };

  return { body: { secret } };
};
