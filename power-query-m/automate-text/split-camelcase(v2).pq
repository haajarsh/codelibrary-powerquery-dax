// For example if wants to rename the column from "DeliveryDate" to "Delivery Date"

(Source) =>
let    
    res = List.Accumulate(
        Text.ToList(Source),
        [result="", index=0, source=Source],
        fnAccumulator
    ),

    IsUpper = (txt) => txt <> "" and txt = Text.Upper(txt) and txt <> Text.Lower(txt),

    fnAccumulator =
        (state as record, current as text) as record =>
        let
            prevCharacter =
                if state[index]=0 then
                    ""
                else
                    Text.At(state[source], state[index] - 1),

            prevCharacter2 =
                if state[index]<=1 then
                    ""
                else
                    Text.At(state[source], state[index] - 2),
            
            nextCharacter =
                if state[index] = Text.Length(state[source]) - 1 then
                    ""
                else
                    Text.At(state[source], state[index] + 1),

            aggregatedResult = 
                if state[index]=0 or current = "" then
                    current
                else
                    if  IsUpper(current) and
                        (not IsUpper(prevCharacter) or 
                         (IsUpper(prevCharacter2) and not IsUpper(nextCharacter))) then
                    state[result] & " " & current
                else
                    state[result] & current,
            
            resultRecord =
            if aggregatedResult = null then
                null
            else
                [result = aggregatedResult, index = state[index]+1, source = state[source]]

        in
            resultRecord
in
    res[result]