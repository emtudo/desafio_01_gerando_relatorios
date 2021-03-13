defmodule Desafio01GerandoRelatorios do
  alias Desafio01GerandoRelatorios.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(model(), &process_report/2)
  end

  defp process_report([freelancer, hours, _day, month, year], report) do
    all_hours = accumulate(report.all_hours, freelancer, hours)
    hours_per_month = accumulate(report.hours_per_month, freelancer, hours, month)
    hours_per_year = accumulate(report.hours_per_year, freelancer, hours, year)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp accumulate(report, freelancer, hours), do: sum_value(report, freelancer, hours)

  defp accumulate(report, freelancer, hours, kind),
    do: sum_by_kind(report, freelancer, kind, hours)

  defp sum_by_kind(map, freelancer, kind, hours) do
    value =
      Map.get(map, freelancer, %{})
      |> sum_value(kind, hours)

    Map.put(map, freelancer, value)
  end

  defp sum_value(map, key, hours) do
    total = Map.get(map, key, 0) + hours
    Map.put(map, key, total)
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year}
  end

  defp model(), do: %{all_hours: %{}, hours_per_month: %{}, hours_per_year: %{}}
end
