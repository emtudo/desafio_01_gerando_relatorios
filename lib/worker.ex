defmodule Desafio01GerandoRelatorios.Worker do
  def run do
    receive do
      {:diego, line} -> IO.puts("Hi, #{line}")
      {_, _} -> IO.puts("_")
    end
  end
end
