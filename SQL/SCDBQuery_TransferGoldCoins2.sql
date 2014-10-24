/* 
	Author: Storm
	Description: Transfers players bank money from morality fiedld in player_data to banksaldo in banking_data 
	
*/

INSERT IGNORE INTO banking_data 
(PlayerUID, PlayerName)
(SELECT PlayerUID, PlayerName FROM player_data);

UPDATE banking_data
SET BankSaldo = (SELECT PlayerMorality FROM player_data WHERE PlayerUID = banking_data.PlayerUID);