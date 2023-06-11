import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile.{read}

pub fn main() {
  let ordered = case read(from: "./src/input.txt") {
    Ok(f) -> ordered_capacities(f)
    Error(_) -> [0]
  }

  let assert Ok(part1) =
    list.first(ordered)
    |> result.try(fn(x) { Ok(int.to_string(x)) })
  let part2 = case ordered {
    [f, s, t, ..] -> int.to_string(f + s + t)
    _other -> "error"
  }

  io.println("Part 1: " <> part1)
  io.println("Part 2: " <> part2)
}

fn sum_strings(strings) -> Int {
  list.fold(
    strings,
    0,
    fn(sum, str) {
      let assert Ok(n) = int.parse(str)
      sum + n
    },
  )
}

fn ordered_capacities(file) {
  file
  |> string.trim
  |> string.split("\n\n")
  |> list.map(fn(lines) { string.split(lines, "\n") })
  |> list.map(sum_strings)
  |> list.sort(int.compare)
  |> list.reverse
}
