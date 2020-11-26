module Constants
  MAP = {
    2 => [0, 2], #name|index|prime
    3 => [1, 3],
    4 => [2, 5],
    5 => [3, 7],
    6 => [4, 11],
    7 => [5, 13],
    8 => [6, 17],
    9 => [7, 19],
    10 => [8, 23],
    11 => [9, 29],
    12 => [10, 31],
    13 => [11, 37],
    1 => [12, 41]
  }
  MAP_SUITS = {
    "C" => 0x8000,
    "D" => 0x4000,
    "H" => 0x2000,
    "S" => 0x1000
  }
  HAND_TYPES = %w[ロイヤルフラッシュ ストレートフラッシュ フォー・オブ・ア・カインド フルハウス フラッシュ ストレート スリー・オブ・ア・カインド ツーペア ワンペア ハイカー]
  HANDTYPES_ROYAL_FLUSH = 0
  HANDTYPES_STRAIGHT_FLUSH = 1
  HANDTYPES_4_OF_A_KIND = 2
  HANDTYPES_FULL_HOUSE = 3
  HANDTYPES_FLUSH = 4
  HANDTYPES_STRAIGHT = 5
  HANDTYPES_3_OF_A_KIND = 6
  HANDTYPES_2_PAIRS = 7
  HANDTYPES_1_PAIR = 8
  HANDTYPES_HIGH_CARD = 9

end
