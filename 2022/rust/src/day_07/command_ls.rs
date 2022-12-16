use std::str::FromStr;

pub(crate) struct Ls {
    pub(crate) entries: Vec<LsEntry>,
}

impl FromStr for Ls {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let entries = s.lines().filter_map(|line| line.parse().ok()).collect();

        Ok(Ls { entries })
    }
}

pub(crate) enum LsEntry {
    Dir(String),
    File(String, usize),
}

impl FromStr for LsEntry {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (left, right) = s
            .split_once(' ')
            .ok_or(format!("Unable to parse dir command: {s}"))?;

        if left.contains("dir") {
            Ok(Self::Dir(right.to_owned()))
        } else {
            let file_size = left
                .parse::<usize>()
                .map_err(|_| format!("Unable to parse size of file: {s}"))?;

            let file_name = right.to_string();

            Ok(Self::File(file_name, file_size))
        }
    }
}
