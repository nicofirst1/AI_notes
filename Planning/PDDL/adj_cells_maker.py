



def get_adj(i,j,matrix):
    rows=len(matrix)
    cols=len(matrix[0])

    up,left,down,right,ur,dl,dr,ul=1,1,1,1,1,1,1,1

    if  j-1>=0:
        left=matrix[i][j-1]

    if  i-1>=0:
        up=matrix[i-1][j]
    
    if  j+1<cols:
        right=matrix[i][j+1]

    if i+1<rows:
        down=matrix[i+1][j]

    if j-1>= 0 and i+1<rows:
        dl=matrix[i+1][j-1]

    if j+1<cols and i-1>=0:
        ur=matrix[i-1][j+1]

    if j+1<cols and i+1<rows:
        dr=matrix[i+1][j+1]

    if j-1>=0 and i-1>=0:
        ul=matrix[i-1][j-1]

    return up,left,down,right,ur,dl,dr,ul

def get_adj_print(input, diagonal=True):
    
    input=input.strip("\n")
    lines=input.split("\n")
    matrix=[[int(elem) for elem in line] for line in lines]
    rows=len(matrix)
    cols=len(matrix[0])

    to_ret=""

    for i in range(rows):
        for j in range(cols):
            
            if matrix[i][j]:continue
            up,left,down,right,ur,dl,dr,ul=get_adj(i,j,matrix)

            if not left:
                to_ret+=f"(adj s{i}{j} s{i}{j-1})"

            if not up:
                to_ret+=f"(adj s{i}{j} s{i-1}{j})"
            if not right:
                to_ret+=f"(adj s{i}{j} s{i}{j+1})"
            if not down:
                to_ret+=f"(adj s{i}{j} s{i+1}{j})"

            if not dl and diagonal:
                to_ret+=f"(adj s{i}{j} s{i+1}{j-1})"
            if not ur and diagonal:
                to_ret+=f"(adj s{i}{j} s{i-1}{j+1})"
            if not dr and diagonal:
                to_ret+=f"(adj s{i}{j} s{i+1}{j+1})"
            if not ul and diagonal:
                to_ret+=f"(adj s{i}{j} s{i-1}{j-1})"
            
            to_ret+="\n"
     
    to_ret1=""
    for i in range(rows):
        for j in range(cols):
            to_ret1+=f"s{i}{j} "

    to_ret1+="\n"+to_ret
    return to_ret1



if __name__ == "__main__":
    
    # Make adjacent cells for a grid world given some input
    # zeros are traversable path, ones are obstacles
    input="""
    0000
    0000
    """
    # allow diagonal connections?
    diagonal_movement=False

    ret=get_adj_print(input,diagonal_movement)

    print(ret)
