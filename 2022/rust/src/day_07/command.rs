use std::str::FromStr;

use super::{command_cd::Cd, command_ls::Ls};

pub(crate) enum Command {
    Cd(Cd),
    Ls(Ls),
}

impl FromStr for Command {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (command, output) = s.split_once('\n').unwrap_or((s, s));

        if command.contains("cd") {
            Ok(Command::Cd(command.parse()?))
        } else if command.contains("ls") {
            Ok(Command::Ls(output.parse()?))
        } else {
            Err(format!("Unknown command: {command}"))
        }
    }
}
