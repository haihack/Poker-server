module Constants
  $map = {
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
  $mapSuits = {
    "C" => 0x8000,
    "D" => 0x4000,
    "H" => 0x2000,
    "S" => 0x1000
  }
  $handTypes = %w[ロイヤルフラッシュ ストレートフラッシュ フォー・オブ・ア・カインド フルハウス フラッシュ ストレート スリー・オブ・ア・カインド ツーペア ワンペア ハイカー]
  $handTypes_royal_flush = 0
  $handTypes_straight_flush = 1
  $handTypes_4_of_a_kind = 2
  $handTypes_full_house = 3
  $handTypes_flush = 4
  $handTypes_straight = 5
  $handTypes_3_of_a_kind = 6
  $handTypes_2_pairs = 7
  $handTypes_1_pair = 8
  $handTypes_high_card = 9

end
