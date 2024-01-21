# jalias

给你的路径名起个名字！！！

* 适用于所有命令
* 支持自动补全

## 安装


```sh
cd jalias
make zsh_install
```

## 用法

* add / + : 给当前目录一个别名 `jalias + proj`
* del / - : 删除别名 `jalias - proj`
* l : 查看所有别名
* clean : 删除全部别名

```sh
                                                                                                                                                            
> ~/Project/jalias $ pwd
/Users/junbao/Project/jalias
                                                                                                                                
> ~/Project/jalias $ ls -a                                                     
.         ..        .idea     Makefile  README.md bin       cmd       go.mod    internal  scripts
                                                                                                                                
> ~/Project/jalias $ jalias + ja                                     
/Users/junbao/Project/jalias
                                                                                                                               
> ~/Project/jalias $ jalias l                                        
ja/ proj
                                                                                                                                                            
> ~/Project/jalias $ cd /        
                                                                                                                                  
> / $ jalias cd ja
                                                                                                                            
> ~/Project/jalias $ cd /
                                                                                                                                
> / $ jalias ls -a ja/cmd/         
.         ..        jalias.go              
```