import { getStats } from '$lib/api';
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async ({ fetch }) => {
  const stats = await getStats(fetch);

  return stats;
};
