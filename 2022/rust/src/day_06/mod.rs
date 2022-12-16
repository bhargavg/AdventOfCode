use std::collections::HashSet;

pub(crate) fn part1(input: &str) -> String {
    helper(input, 4).to_string()
}

pub(crate) fn part2(input: &str) -> String {
    helper(input, 14).to_string()
}

fn helper(input: &str, window_size: usize) -> usize {
    input
        .chars()
        .collect::<Vec<_>>()
        .windows(window_size)
        .enumerate()
        .find_map(|(idx, chars)| {
            let set = chars.iter().collect::<HashSet<&char>>();

            if set.len() == window_size {
                Some(idx + window_size)
            } else {
                None
            }
        })
        .unwrap()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1_example() {
        assert_eq!(part1("bvwbjplbgvbhsrlpgdmjqwftvncz"), "5");
        assert_eq!(part1("nppdvjthqldpwncqszvftbrmjlhg"), "6");
        assert_eq!(part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), "10");
        assert_eq!(part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), "11");
    }

    #[test]
    fn test_part2_example() {
        assert_eq!(part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), "19");
        assert_eq!(part2("bvwbjplbgvbhsrlpgdmjqwftvncz"), "23");
        assert_eq!(part2("nppdvjthqldpwncqszvftbrmjlhg"), "23");
        assert_eq!(part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), "29");
        assert_eq!(part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), "26");
    }
}
