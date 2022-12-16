use std::{cell::RefCell, rc::Rc};

mod command;
mod command_cd;
mod command_ls;
mod node;

use self::{command::Command, command_cd::CdDestination, command_ls::LsEntry, node::Node};

pub(crate) fn part1(input: &str) -> String {
    let root = parse(input);

    let mut to_visit = vec![Rc::clone(&root)];
    let mut total: usize = 0;

    while let Some(node) = to_visit.pop() {
        for child_node in node
            .borrow()
            .children
            .values()
            .filter(|n| n.borrow().is_dir())
        {
            to_visit.push(Rc::clone(child_node));
        }

        let size = node.borrow().total_size();

        if size <= 100000 {
            total += size;
        }
    }

    total.to_string()
}

pub(crate) fn part2(input: &str) -> String {
    let root = parse(input);

    let mut to_visit = vec![Rc::clone(&root)];
    let mut smallest = usize::MAX;

    let free_space = 70000000 - root.borrow().total_size();
    let size_required = 30000000 - free_space;

    while let Some(node) = to_visit.pop() {
        for child_node in node
            .borrow()
            .children
            .values()
            .filter(|n| n.borrow().is_dir())
        {
            to_visit.push(Rc::clone(child_node));
        }

        let size = node.borrow().total_size();

        if size >= size_required {
            smallest = smallest.min(size);
        }
    }

    smallest.to_string()
}

fn parse(input: &str) -> Rc<RefCell<Node>> {
    let root = Rc::new(RefCell::new(Node::default()));
    let mut node = root.clone();

    let commands = input
        .split("\n$")
        .filter_map(|chunk| chunk.parse::<Command>().ok());

    for command in commands {
        match command {
            Command::Cd(cd) => match cd.destination {
                CdDestination::Root => { /* ignore, we are already here. */ }
                CdDestination::Parent => {
                    let parent = node.borrow().parent.clone().unwrap();
                    node = parent;
                }
                CdDestination::Dir(dir_name) => {
                    let child = node
                        .borrow_mut()
                        .children
                        .entry(dir_name.clone())
                        .or_default()
                        .clone();
                    node = child;
                }
            },
            Command::Ls(ls) => {
                for entry in ls.entries {
                    match entry {
                        LsEntry::Dir(name) => {
                            let entry = node
                                .borrow_mut()
                                .children
                                .entry(name.clone())
                                .or_default()
                                .clone();
                            entry.borrow_mut().parent = Some(node.clone());
                        }
                        LsEntry::File(name, size) => {
                            let entry = node
                                .borrow_mut()
                                .children
                                .entry(name.clone())
                                .or_default()
                                .clone();
                            entry.borrow_mut().size = size as usize;
                            entry.borrow_mut().parent = Some(node.clone());
                        }
                    }
                }
            }
        }
    }

    root
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
";

    #[test]
    fn test_part1_example() {
        assert_eq!(part1(INPUT), "95437");
    }

    #[test]
    fn test_part2_example() {
        assert_eq!(part2(INPUT), "24933642");
    }
}
