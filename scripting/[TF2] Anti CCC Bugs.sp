#pragma semicolon 1
#include <sourcemod>
#include <morecolors>

#pragma newdecls required

public const char sCodes[][] = {"\x01", "\x02", "\x03", "\x04", "\x05", "\x06", "\x07", "\x08"};

public Plugin myinfo = 
{
	name = "[TF2] Anti CCC Bugs",
	author = "yelks",
	description = "",
	version = "1.0",
	url = "https://steamcommunity.com/id/kenmaskimmeod/"
};

public void OnPluginStart()
{
	AddCommandListener(OnSayCommand, "say");
	AddCommandListener(OnSayCommand, "say2");
	AddCommandListener(OnSayCommand, "say_team");
}

public Action OnSayCommand(int client, const char[] command, int argc)
{
	char text[192];
	int startidx = 0;
	if (GetCmdArgString(text, sizeof(text)) < 1)
	{
		return Plugin_Continue;
	}
	
	if (text[strlen(text)-1] == '"')
	{
		text[strlen(text)-1] = '\0';
		startidx = 1;
	}

	if (strcmp(command, "say2", false) == 0)
	{
		startidx += 4;
	}
	
	for (int i = 0; i < sizeof(sCodes); i++)
	{
		if (StrContains(text[startidx], sCodes[i], false) > -1)
		{
			CPrintToChat(client, "{orange}[{green}SM{orange}]{default} Invalid chat characters.");
			return Plugin_Handled;
		}
	}
	
	return Plugin_Continue;
}
