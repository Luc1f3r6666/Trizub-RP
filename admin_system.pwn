
// Структура для адмінів
new adminLevel[MAX_PLAYERS]; // Масив для рівнів доступу

// Паролі для кожного рівня
new adminPassword[12][32] = {
    "password1", // Рівень 1
    "password2", // Рівень 2
    "password3", // Рівень 3
    "password4", // Рівень 4
    "password5", // Рівень 5
    "password6", // Рівень 6
    "password7", // Рівень 7
    "password8", // Рівень 8
    "password9", // Рівень 9
    "password10", // Рівень 10
    "password11", // Рівень 11
    "password12"  // Рівень 12
};

// Функція для перевірки паролю
public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp(cmdtext, "/setadmin", true) == 0) {
        // Ввести пароль для активації адмінки
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "Введіть пароль адміністратора", "Введіть ваш пароль для активації адмінських прав", "OK", "Cancel");
        return 1;
    }
    return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == 1 && response == 1) {
        // Перевіряємо введений пароль
        for (new level = 0; level < 12; level++) {
            if (strcmp(inputtext, adminPassword[level], true) == 0) {
                adminLevel[playerid] = level + 1;
                SendClientMessage(playerid, COLOR_GREEN, "Вітаємо! Ви стали адміністратором рівня %d.", adminLevel[playerid]);
                return 1;
            }
        }
        SendClientMessage(playerid, COLOR_RED, "Невірний пароль.");
    }
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (adminLevel[playerid] >= 1 && strcmp(cmdtext, "/teleport", true) == 0) {
        // Команда для телепортації доступна з рівня 1
        TeleportPlayer(playerid, 2000.0, 2000.0, 10.0);
        return 1;
    }

    if (adminLevel[playerid] >= 2 && strcmp(cmdtext, "/ban", true) == 0) {
        // Команда для бана доступна з рівня 2
        BanPlayer(playerid);
        return 1;
    }

    if (adminLevel[playerid] >= 5 && strcmp(cmdtext, "/createfaction", true) == 0) {
        // Створення фракції доступне з рівня 5
        CreateFaction(playerid);
        return 1;
    }

    return 0;
}
