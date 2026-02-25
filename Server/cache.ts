import { Client } from "whatsapp-web.js";

type ChatCache = {
  chatList: any[];
  groupList: any[];
  lastUpdate: number;
  loading: boolean;
};

export const chatCache: ChatCache = {
  chatList: [],
  groupList: [],
  lastUpdate: 0,
  loading: false,
};

export async function refreshChats(client: Client) {
  if (chatCache.loading) return;
  chatCache.loading = true;

  try {
    const allChats = await client.getChats();

    chatCache.chatList = allChats.filter(c => !c.isGroup);
    chatCache.groupList = allChats.filter(c => c.isGroup);
    chatCache.lastUpdate = Date.now();

    console.log("Chats refreshed:", chatCache.chatList.length);
  } catch (e: any) {
    console.log("refreshChats failed:", e.message);
  }

  chatCache.loading = false;
}