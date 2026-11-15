///|
/// 日期工具：YYYY-MM-DD 格式校验、“YYYY-MM-DD”↔ 自 1970-01-01 起的天数、
/// 毫秒时间戳 → 今天。日历算法用 Howard Hinnant 的 days_from_civil /
/// civil_from_days（公开的标准算法）。核验过期阈值 STALE_DAYS = 30 天
/// 是本工具的政策（价格每月至少复核一次），不是官方规定，写在这里，别藏着。

///|
/// 日期格式 YYYY-MM-DD：长度 10，第 5、8 位为 '-'，其余为数字，
/// 月 01–12，日 01–31（不校验每月实际天数，如 02-31 不拦截）。
pub fn is_valid_date(s : String) -> Bool {
  if s.length() != 10 {
    return false
  }
  let chars = s.to_array()
  if chars[4] != '-' || chars[7] != '-' {
    return false
  }
  for i in [0, 1, 2, 3, 5, 6, 8, 9] {
    if !chars[i].is_ascii_digit() {
      return false
    }
  }
  let month_ok = (chars[5] == '0' && chars[6] >= '1' && chars[6] <= '9') ||
    (chars[5] == '1' && chars[6] >= '0' && chars[6] <= '2')
  let day_ok = (chars[8] == '0' && chars[9] >= '1' && chars[9] <= '9') ||
    ((chars[8] == '1' || chars[8] == '2') && chars[9] >= '0' && chars[9] <= '9') ||
    (chars[8] == '3' && chars[9] >= '0' && chars[9] <= '1')
  month_ok && day_ok
}

///|
/// "YYYY-MM-DD" → 自 1970-01-01 起的天数；格式不对返回 -1。
pub fn date_to_days(s : String) -> Int32 {
  if !is_valid_date(s) {
    return -1
  }
  let chars = s.to_array()
  let y = digit_value(chars[0]) * 1000 +
    digit_value(chars[1]) * 100 +
    digit_value(chars[2]) * 10 +
    digit_value(chars[3])
  let m = digit_value(chars[5]) * 10 + digit_value(chars[6])
  let d = digit_value(chars[8]) * 10 + digit_value(chars[9])
  days_from_civil(y, m, d)
}

///|
fn digit_value(c : Char) -> Int32 {
  match c {
    '0' => 0
    '1' => 1
    '2' => 2
    '3' => 3
    '4' => 4
    '5' => 5
    '6' => 6
    '7' => 7
    '8' => 8
    '9' => 9
    _ => -1
  }
}

///|
fn days_from_civil(y0 : Int32, m : Int32, d : Int32) -> Int32 {
  let y = if m <= 2 { y0 - 1 } else { y0 }
  let era = (if y >= 0 { y } else { y - 399 }) / 400
  let yoe = y - era * 400
  let mp = if m > 2 { m - 3 } else { m + 9 }
  let doy = (153 * mp + 2) / 5 + d - 1
  let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy
  era * 146097 + doe - 719468
}

///|
/// 自 1970-01-01 起的天数 → "YYYY-MM-DD"。
pub fn days_to_date(days : Int32) -> String {
  let (y, m, d) = civil_from_days(days)
  y.to_string().pad_start(4, '0') +
  "-" +
  m.to_string().pad_start(2, '0') +
  "-" +
  d.to_string().pad_start(2, '0')
}

///|
fn civil_from_days(z0 : Int32) -> (Int32, Int32, Int32) {
  let z = z0 + 719468
  let era = (if z >= 0 { z } else { z - 146096 }) / 146097
  let doe = z - era * 146097
  let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365
  let y = yoe + era * 400
  let doy = doe - (365 * yoe + yoe / 4 - yoe / 100)
  let mp = (5 * doy + 2) / 153
  let d = doy - (153 * mp + 2) / 5 + 1
  let m = if mp < 10 { mp + 3 } else { mp - 9 }
  if m <= 2 {
    (y + 1, m, d)
  } else {
    (y, m, d)
  }
}

///|
/// 毫秒时间戳（@env.now()）→ 自 1970-01-01 起的天数。
pub fn today_days(now_ms : UInt64) -> Int32 {
  (now_ms / 86400000UL).to_int()
}

///|
/// 毫秒时间戳 → 今天 "YYYY-MM-DD"。
pub fn today_string(now_ms : UInt64) -> String {
  days_to_date(today_days(now_ms))
}

///|
/// 北京时间今天（UTC+8）：本项目所有日期（verified_at、复核会话日期）都是
/// 北京时间日期；服务器时钟是 UTC，直接用会把北京时间的“今天”算成昨天，
/// 导致刚复核过的记录被误判过期（R4 发现：274 条 11-16 的记录在 UTC 11-15
/// 当天被算成过期，CLI 的 report/stale 都受影响）。
pub fn today_days_cst(now_ms : UInt64) -> Int32 {
  today_days(now_ms + 28800000UL)
}

///|
/// 核验过期阈值：verified_at 距今超过 30 天算过期。
pub const STALE_DAYS : Int32 = 30

///|
/// verified_at 距今多少天；格式不对返回 -1。
pub fn days_since_verified(verified_at : String, today : Int32) -> Int32 {
  let v = date_to_days(verified_at)
  if v < 0 {
    -1
  } else {
    today - v
  }
}

///|
/// 是否过期：距今超过 STALE_DAYS 天。格式不对的日期也算过期
/// （数据有问题，不能当新鲜的用）。
pub fn is_stale(verified_at : String, today : Int32) -> Bool {
  let days = days_since_verified(verified_at, today)
  days < 0 || days > STALE_DAYS
}
