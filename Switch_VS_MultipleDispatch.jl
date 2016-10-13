
# Winner: multiple dispatch

"""
_str_to_value_exp( Nullable{Float64}, \"10.0\" ) -> \"Nullable(float(\"10.0\"))\"
"""
function convert_exp_switch(t::DataType, str_expression::String) :: String
    if t == String
        return str_expression
    end

    if t == Nullable{String}
        return "Nullable($str_expression)"
    end

    if t == Nullable{Float64}
        return "Nullable(float($str_expression))"
    end

    if t == Nullable{Date}
        return "Nullable(Date($str_expression))"
    end

    error("DataType not supported: $t")
end

convert_exp_md(::Type{Any}, str_expression::String) :: String = error("DataType not supported $t")
convert_exp_md(::Type{String}, str_expression::String) :: String = str_expression
convert_exp_md(::Type{Nullable{String}}, str_expression::String) :: String = "Nullable($str_expression)"
convert_exp_md(::Type{Nullable{Float64}}, str_expression::String) :: String = "Nullable(float($str_expression))"
convert_exp_md(::Type{Nullable{Date}}, str_expression::String) :: String = "Nullable(Date($str_expression))"

function run_bench()
        # warmup
    convert_exp_switch( String, "2016-05-02")
    convert_exp_switch( Nullable{String}, "2016-05-02")
    convert_exp_switch( Nullable{Float64}, "10.2")
    convert_exp_switch( Nullable{Date}, "2016-05-02")
    
    convert_exp_md( String, "2016-05-02")
    convert_exp_md( Nullable{String}, "2016-05-02")
    convert_exp_md( Nullable{Float64}, "10.2")
    convert_exp_md( Nullable{Date}, "2016-05-02")

    println("switch")
    @time for i in 1:1000000
        convert_exp_switch( String, "2016-05-02")
        convert_exp_switch( Nullable{String}, "2016-05-02")
        convert_exp_switch( Nullable{Float64}, "10.2")
        convert_exp_switch( Nullable{Date}, "2016-05-02")
    end

    println("Multiple Dispatch")
    @time for i in 1:1000000
        convert_exp_md( String, "2016-05-02")
        convert_exp_md( Nullable{String}, "2016-05-02")
        convert_exp_md( Nullable{Float64}, "10.2")
        convert_exp_md( Nullable{Date}, "2016-05-02")
    end
end

run_bench()
