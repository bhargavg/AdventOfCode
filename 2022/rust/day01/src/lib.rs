use std::env;
use std::fs;

fn read_file(name: &str) -> String {
    let file_path = env::current_dir().unwrap().join("inputs").join(name);
    fs::read_to_string(&file_path).unwrap_or(format!("Unable to read file at: {:?}", &file_path))
}

fn helper(input: &str, count: usize) -> u32 {
    let mut foo = input
        .split("\n\n")
        .map(|lines| {
            lines
                .lines()
                .map(|line| line.parse::<u32>().unwrap())
                .sum::<u32>()
        })
        .collect::<Vec<u32>>();

    foo.sort();

    foo.iter().rev().take(count).sum()
}

fn part1(input: &str) -> u32 {
    helper(input, 1)
}

fn part2(input: &str) -> u32 {
    helper(input, 3)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1_example() {
        let contents = read_file("part1_example.txt");
        assert_eq!(part1(&contents), 24000);
    }

    #[test]
    fn test_part1() {
        let contents = read_file("part1.txt");
        assert_eq!(part1(&contents), 75622);
    }

    #[test]
    fn test_part2_example() {
        let contents = read_file("part2_example.txt");
        assert_eq!(part2(&contents), 45000);
    }

    #[test]
    fn test_part2() {
        let contents = read_file("part2.txt");
        assert_eq!(part2(&contents), 213159);
    }
}
