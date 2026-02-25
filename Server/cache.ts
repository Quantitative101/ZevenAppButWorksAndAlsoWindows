import { Client } from "whatsapp-web.js";

type ChatCache = {
  chatList: any[];
  groupList: any[];
  loading: boolean;
};

export const chatCache: ChatCache = {
  chatList: [],
  groupList: [],
  loading: true
};

export async function refreshChats(client: Client) {
  try {
    const allChats = await client.getChats();
    chatCache.chatList = allChats.filter(c => !c.isGroup);
    chatCache.groupList = allChats.filter(c => c.isGroup);
  } catch (e: any) {
    console.log("refreshChats failed:", e.message);
  }

  chatCache.loading = false;
}