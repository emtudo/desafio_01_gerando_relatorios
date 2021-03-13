defmodule Desafio01GerandoRelatorios do
  alias Desafio01GerandoRelatorios.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(model(), &process_report/2)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1, timeout: :infinity)
      |> IO.inspect()
      |> Enum.reduce(model(), &process_report_all/2)

    {:ok, result}
  end

  defp process_report_all({:ok, left}, right) do
    all_hours = recursive_sum(left.all_hours, right.all_hours)
    hours_per_month = recursive_sum(left.hours_per_month, right.hours_per_month)
    hours_per_year = recursive_sum(left.hours_per_year, right.hours_per_year)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp recursive_sum(left, right) when is_map(left) do
    Map.merge(left, right, fn _key, left_value, right_value ->
      recursive_sum(left_value, right_value)
    end)
  end

  defp recursive_sum(left, right), do: left + right

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
