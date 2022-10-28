### init ci/cd
- step 1: change main.yaml tag {{build}}
- step 2: commit code master
- step 3: git tag {{build}}
- step 4: git push origin {{build}}

## note remove tag
    -  git tag -d {{tag}}
    - get push --delete origin {{tag}}