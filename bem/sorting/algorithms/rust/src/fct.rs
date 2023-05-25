// Axam - 24.05.2023

#[inline(always)]
pub fn bubble_sort(numbers: &mut Vec<u16>, useOpti: bool) -> Vec<u16>
{
  let mut temp;
  let length = numbers.len();
  let mut isSwapped = false;

  for _ in 0..length {
    isSwapped = false;
    for j in 0..length - 1 {
      if numbers[j] > numbers[j+1]  {
        temp = numbers[j+1];
        numbers[j+1] = numbers[j];
        numbers[j] = temp;
        isSwapped = true;
      }
    }
    if useOpti && !isSwapped {
      break;
    }
  }
  numbers.to_vec()
}
