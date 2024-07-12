List.Dates(#date(2024,01,01), //Start Date
365*10, //Date for every day for the next 10 years
#duration(1,0,0,0)) //specifies duration of the period 1 = days, 0 = hours, 0 = minutes, 0 = seconds


---
List.Dates(#date(2024,01,01), 365*10, #duration(1,0,0,0))