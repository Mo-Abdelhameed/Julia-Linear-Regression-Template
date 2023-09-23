import json

def notebook_to_script(ipynb_filename, jl_filename):
    with open(ipynb_filename, 'r') as f:
        notebook = json.load(f)
        
    with open(jl_filename, 'w') as f:
        for cell in notebook['cells']:
            if cell['cell_type'] == 'code':
                f.write("#= Start of Cell =#\n")
                f.write(''.join(cell['source']))
                f.write("\n#= End of Cell =#\n\n")

ipynb_filename = "train.ipynb"
jl_filename = "train.jl"

notebook_to_script(ipynb_filename, jl_filename)
