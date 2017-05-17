"Return a string of the value as a percentage, rounded to one digit."
perc(x::Real) = @sprintf("%.1f%%", x*100)

"Return a string of `count` and percentage of `total` (in parentheses)."
count_and_perc(count, total) = "$(count)  ($(perc(count/total)))"
