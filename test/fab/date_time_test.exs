defmodule Fab.DateTimeTest do
  use ExUnit.Case, async: true

  test "anytime/0" do
    now = DateTime.utc_now()

    anytime = Fab.DateTime.anytime(ref_date: now)

    diff = DateTime.diff(anytime, now)

    assert diff > 0 || diff < 0
  end

  test "between/1" do
    from = DateTime.utc_now()
    to = Map.put(from, :year, from.year + 10)

    between = Fab.DateTime.between(from: from, to: to)

    assert DateTime.diff(between, from) > 0
    assert DateTime.diff(between, to) < 0
  end

  test "future/1" do
    now = DateTime.utc_now()

    future = Fab.DateTime.future(ref_date: now)

    assert DateTime.diff(future, now) > 0

    future = Fab.DateTime.future(ref_date: now, years: 10)

    assert DateTime.diff(future, now)
  end

  test "past/1" do
    now = DateTime.utc_now()

    past = Fab.DateTime.past(ref_date: now)

    assert DateTime.diff(past, now) < 0

    past = Fab.DateTime.past(ref_date: now, years: 10)

    assert DateTime.diff(past, now) < 0
  end

  test "recent/1" do
    now = DateTime.utc_now()

    recent = Fab.DateTime.recent(days: 10, ref_date: now)

    assert DateTime.diff(recent, now) < 0
  end

  test "soon/1" do
    now = DateTime.utc_now()

    soon = Fab.DateTime.soon(ref_date: now)

    assert DateTime.diff(soon, now) > 0

    soon = Fab.DateTime.soon(days: 10, ref_date: now)

    assert DateTime.diff(soon, now) > 0
  end
end
