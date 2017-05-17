"Return the value as a percentage, rounded to one digit, as a string."
perc(x::Real) = @sprintf("%.1f%%", x*100)
