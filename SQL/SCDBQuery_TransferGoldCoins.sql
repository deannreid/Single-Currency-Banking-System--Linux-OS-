
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Transfer goldcoins from `HeadShots` to `CashMoney` field
-- ----------------------------

UPDATE character_data
SET CashMoney = HeadshotsZ