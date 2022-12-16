mod max_offsets;
use itertools::Itertools;
use max_offsets::MaxOffsets;

pub(crate) fn part1(input: &str) -> String {
    let grid = parse(input);
    let mut count = 0;

    for (i, row) in grid.iter().enumerate() {
        for (j, _) in row.iter().enumerate() {
            if is_visible_from_any_direction(&grid, i, j) {
                count += 1;
            }
        }
    }

    count.to_string()
}

pub(crate) fn part2(input: &str) -> String {
    let grid = parse(input);
    let mut count = 0;

    for (i, row) in grid.iter().enumerate() {
        for (j, _) in row.iter().enumerate() {
            count = count.max(compute_scenic_score(&grid, i, j));
        }
    }

    count.to_string()
}

fn parse(input: &str) -> Vec<Vec<u8>> {
    input
        .lines()
        .map(|line| line.as_bytes().iter().map(|b| b - b'0').collect_vec())
        .collect_vec()
}

fn is_visible_from_any_direction(grid: &Vec<Vec<u8>>, i: usize, j: usize) -> bool {
    let max_offsets = find_max_offsets(grid, i, j);

    max_offsets.top == 0
        || max_offsets.right == 0
        || max_offsets.bottom == 0
        || max_offsets.left == 0
}

fn compute_scenic_score(grid: &Vec<Vec<u8>>, i: usize, j: usize) -> usize {
    let mut maxes = find_max_offsets(grid, i, j);

    maxes.top = if maxes.top == 0 { i } else { maxes.top };
    maxes.right = if maxes.right == 0 {
        grid[i].len() - 1 - j
    } else {
        maxes.right
    };
    maxes.bottom = if maxes.bottom == 0 {
        grid.len() - 1 - i
    } else {
        maxes.bottom
    };

    maxes.left = if maxes.left == 0 { j } else { maxes.left };

    maxes.top * maxes.right * maxes.bottom * maxes.left
}

fn find_max_offsets(grid: &Vec<Vec<u8>>, i: usize, j: usize) -> MaxOffsets {
    let mut maxes = MaxOffsets::default();

    for k in 1.. {
        let mut should_continue = false;

        if (i >= k) && maxes.top == 0 {
            if grid[i - k][j] >= grid[i][j] {
                maxes.top = k;
            }
            should_continue = true;
        }

        if (j + k < grid[i].len()) && maxes.right == 0 {
            if grid[i][j + k] >= grid[i][j] {
                maxes.right = k;
            }
            should_continue = true;
        }

        if (i + k < grid.len()) && maxes.bottom == 0 {
            if grid[i + k][j] >= grid[i][j] {
                maxes.bottom = k;
            }
            should_continue = true;
        }

        if (j >= k) && maxes.left == 0 {
            if grid[i][j - k] >= grid[i][j] {
                maxes.left = k;
            }
            should_continue = true;
        }

        if !should_continue {
            break;
        }
    }

    maxes
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = "30373
25512
65332
33549
35390";

    #[test]
    fn test_part_1_example() {
        assert_eq!(part1(INPUT), "21");
    }

    #[test]
    fn test_part_2_example() {
        assert_eq!(part2(INPUT), "8");
    }
}
