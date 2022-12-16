pub(crate) fn part1(input: &str) -> String {
    helper(input, 1).to_string()
}

pub(crate) fn part2(input: &str) -> String {
    helper(input, 3).to_string()
}

fn helper(input: &str, count: usize) -> i32 {
    let mut groups = input
        .split("\n\n")
        .map(|lines| {
            lines
                .lines()
                .map(|line| line.trim())
                .filter(|line| !line.is_empty())
                .map(|line| line.parse::<i32>().unwrap())
                .sum::<i32>()
        })
        .collect::<Vec<i32>>();

    groups.sort();

    groups.iter().rev().take(count).sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = r"1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
";

    #[test]
    fn test_part_1_example() {
        assert_eq!(part1(INPUT), "24000");
    }

    #[test]
    fn test_part_2_example() {
        assert_eq!(part2(INPUT), "45000");
    }
}
