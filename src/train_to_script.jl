using JSON

function notebook_to_script(ipynb_filename, jl_filename)
    data = JSON.parsefile(ipynb_filename)

    open(jl_filename, "w") do f
        for cell in data["cells"]
            if cell["cell_type"] == "code"
                println(f, "#= Start of Cell =#")
                println(f, join(cell["source"], "\n"))
                println(f, "#= End of Cell =#\n\n")
            end
        end
    end
end

notebook_to_script("./train.ipynb", "./train.jl")
