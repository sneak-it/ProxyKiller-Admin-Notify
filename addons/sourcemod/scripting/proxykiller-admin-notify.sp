#include <sourcemod>
#include <ProxyKiller>

#define PREFIX "[ProxyKiller] "

public void OnPluginStart()
{
	LoadTranslations("ProxyKiller-Admin-Notify.phrases");
}

public void ProxyKiller_OnClientResult(ProxyUser pUser, bool result, bool fromCache)
{
	if (!result)
        return;

	char name[MAX_NAME_LENGTH];
	pUser.GetName(name, sizeof(name));
	
	char steamId2[32];
	pUser.GetSteamId2(steamId2, sizeof(steamId2));

	PrintToAdmins("%s%t", PREFIX, "VPNConnect", name, steamId2);
}

// From SB++ https://github.com/sbpp/sourcebans-pp/blob/0a06d934a986f01cc0d40b1859ba08fa70b843f2/game/addons/sourcemod/scripting/sbpp_sleuth.sp#L245
void PrintToAdmins(const char[] format, any ...)
{
	char g_Buffer[256];

	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && CheckCommandAccess(i, "sm_proxykiller_printtoadmins", ADMFLAG_GENERIC))
		{
			SetGlobalTransTarget(i);
			VFormat(g_Buffer, sizeof(g_Buffer), format, 2);
			PrintToChat(i, "%s", g_Buffer);
		}
	}
}