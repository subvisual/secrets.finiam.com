import { checkIfRoomExists } from '$lib/api';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ params, fetch }) => {
  return { room: params.room, roomExists: await checkIfRoomExists(params.room, fetch) };
};
