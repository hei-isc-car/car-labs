// Axam - 24.05.2023

#[inline(always)]
pub fn bubble_sort(numbers: &mut Vec<u16>, use_opti: bool) -> Vec<u16>
{
  let mut temp;
  let length = numbers.len();
  let mut is_swapped: bool;

  for _ in 0..length {
    is_swapped = false;
    for j in 0..length - 1 {
      if numbers[j] > numbers[j+1]  {
        temp = numbers[j+1];
        numbers[j+1] = numbers[j];
        numbers[j] = temp;
        is_swapped = true;
      }
    }
    if use_opti && !is_swapped {
      break;
    }
  }
  numbers.to_vec()
}

pub fn merge_sort(numbers: &mut Vec<u16>) -> Vec<u16> {
    let len = numbers.len();
    if len < 2 {
        return numbers.to_vec();
    }
    let mid = len / 2;
    let left_half = merge_sort(&mut numbers[0..mid].to_vec());
    let right_half = merge_sort(&mut numbers[mid..len].to_vec());
    merge(left_half, right_half)
}

fn merge(left: Vec<u16>, right: Vec<u16>) -> Vec<u16> {
    let (mut left, mut right) = (left.into_iter(), right.into_iter());
    let (mut l, mut r) = (left.next(), right.next());
    let mut merged = Vec::new();
    while l.is_some() || r.is_some() {
        match (l, r) {
            (Some(lv), Some(rv)) if lv <= rv => {
                merged.push(lv);
                l = left.next();
            }
            (Some(lv), Some(rv)) if lv > rv => {
                merged.push(rv);
                r = right.next();
            }
            (Some(lv), None) => {
                merged.push(lv);
                l = left.next();
            }
            (None, Some(rv)) => {
                merged.push(rv);
                r = right.next();
            }
            _ => break,
        }
    }
    merged
}