# algebraic-group
 
## Przetestuj złamanie wiadomości zaszyfrowanej RSA poprzez obliczenie okresu w odpowiedniej grupie. 
### Mamy dany klucz publiczny składający się z liczb N=55 oraz c=17 oraz zakodowaną wiadomość b=4
``` Julia
N = 55 
c = 17 
b = 4
x = Gn{Int64}(c)
```
### oblicz okres r wiadomości b w Gn{N}
``` Julia
r = period(x)
```
### oblicz d - odwrotność do c w Gn{r}. Jest to klucz prywatny
``` Julia
d = reversed(r)
```
### rozkoduj wiadmość a=b^d mod N
``` Julia
a = (b^d.x)%N
```
### sprawdz, ze faktycznie ta wiadomość była zakodowana kluczem (N,c) czyli, że b = a^c mod N
``` Julia
(Gn{Int}(a)^c)
```

