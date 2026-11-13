// Seven cells in a three-column table used to shift every column after the gap.
#import "../../src/apa7/table.typ": apa-table

#apa-table(
  columns: 3,
  header: ([A], [B], [C]),
  [1], [2], [3],
  [4], [5], [6],
  [7],
)
