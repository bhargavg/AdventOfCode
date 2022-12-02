mod utilities;
mod v1;

#[cfg(test)]
mod tests {
    use super::*;
    use utilities::file_utils::read_file;

    #[test]
    fn test_part1_example() {
        let contents = utilities::file_utils::read_file("part1_example.txt");
        assert_eq!(v1::solutions::part1(&contents), 15);
    }

    #[test]
    fn test_part1() {
        let contents = read_file("part1.txt");
        assert_eq!(v1::solutions::part1(&contents), 13009);
    }

    #[test]
    fn test_part2_example() {
        let contents = read_file("part2_example.txt");
        assert_eq!(v1::solutions::part2(&contents), 12);
    }

    #[test]
    fn test_part2() {
        let contents = read_file("part2.txt");
        assert_eq!(v1::solutions::part2(&contents), 10398);
    }
}
