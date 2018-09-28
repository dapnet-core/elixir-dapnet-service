defmodule DapnetServiceTest do
  use ExUnit.Case
  doctest DapnetService

  test "greets the world" do
    assert DapnetService.hello() == :world
  end
end
