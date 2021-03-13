filenames = ["part_1.csv", "part_2.csv", "part_3.csv"]
filename = "gen_report.csv"

Benchee.run(%{
  "build"    => fn -> Desafio01GerandoRelatorios.build(filename) end,
  "build_from_many" => fn ->Desafio01GerandoRelatorios.build_from_many(filenames) end
})
