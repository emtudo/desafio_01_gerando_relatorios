defmodule Desafio01GerandoRelatoriosTest do
  use ExUnit.Case

  describe "build/1" do
    test "build the report" do
      filename = "test.csv"
      response = Desafio01GerandoRelatorios.build(filename)

      expect_response = %{
        all_hours: %{
          cleiton: 19,
          daniele: 21,
          danilo: 7,
          diego: 13,
          giuliano: 14,
          jakeliny: 25,
          joseph: 17,
          mayk: 33,
          rafael: 14
        },
        hours_per_month: %{
          cleiton: %{julho: 7, junho: 4, outubro: 8},
          daniele: %{abril: 7, dezembro: 5, junho: 1, maio: 8},
          danilo: %{abril: 1, fevereiro: 6},
          diego: %{abril: 4, agosto: 4, dezembro: 1, maio: 1, setembro: 3},
          giuliano: %{abril: 1, fevereiro: 9, maio: 4},
          jakeliny: %{dezembro: 1, julho: 8, março: 14, outubro: 2},
          joseph: %{abril: 4, dezembro: 2, março: 3, novembro: 5, setembro: 3},
          mayk: %{abril: 4, dezembro: 5, julho: 7, junho: 3, março: 3, novembro: 4, setembro: 7},
          rafael: %{agosto: 7, julho: 7}
        },
        hours_per_year: %{
          cleiton: %{2016 => 3, 2018 => 7, 2020 => 9},
          daniele: %{2016 => 10, 2017 => 3, 2018 => 7, 2020 => 1},
          danilo: %{2018 => 1, 2019 => 6},
          diego: %{2016 => 3, 2017 => 8, 2018 => 1, 2019 => 1},
          giuliano: %{2017 => 3, 2019 => 6, 2020 => 5},
          jakeliny: %{2016 => 8, 2017 => 8, 2019 => 7, 2020 => 2},
          joseph: %{2017 => 3, 2019 => 3, 2020 => 11},
          mayk: %{2016 => 11, 2017 => 8, 2019 => 7, 2020 => 7},
          rafael: %{2017 => 14}
        }
      }

      assert expect_response == response
    end
  end
end
