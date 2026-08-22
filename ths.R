# Wyznaczenie wartości c_a i c_b

cb <- function(ca, n, alpha){
  4*qchisq(1 - alpha + pchisq(ca/4,n-1), n-1)
}

g <- function(ca, n, alpha){
  pchisq(cb(ca, n, alpha)/4,n+1)-pchisq(ca/4, n+1) - (1-alpha)
}

n <- 40
alpha <- 0.05


krok <- 0.001
x <- 0.001  # zaczynam od wartosci dodatnich
x_max <- 100

#do przechowywania poprzedniej wartości
prev_g <- g(x, n, alpha)
prev_x <- x

wart_ujemna <- NA
wart_dodatnia <- NA

# szukanie przedziału zmiany znaku dla g()
while(x <= x_max) {
  curr_g <- g(x, n, alpha)
  
  if(prev_g * curr_g < 0) {
    if(curr_g > 0) {
      wart_ujemna <- prev_x
      wart_dodatnia <- x
    } else {
      wart_ujemna <- x
      wart_dodatnia <- prev_x
    }
    break
  }
  prev_x <- x
  prev_g <- curr_g
  x <- x + krok
}

a<-wart_ujemna
b<-wart_dodatnia

#metoda bisekcji
bisekcja <- function(f, a, b, n, alpha, eps = 1e-7, max_i = 10000){
  i<-0
  while ((b-a)/2 > eps & i<max_i){
    m <- (a+b)/2
    
    if (f(a, n, alpha) * f(m, n, alpha) < 0){
      b <- m
    } else {
      a <- m
    }
    i <- i + 1
  }
  return ((a+b)/2)
}


ca_k <- bisekcja(g, a, b , n, alpha)
cb_k <- cb(ca_k, n, alpha)

ca_k
cb_k

#sprawdzenie
pchisq(cb_k/4, n-1)-pchisq(ca_k/4, n-1)
pchisq(cb_k/4, n+1)-pchisq(ca_k/4, n+1)


#=============================

# Część zadania (test i wykres)

TestSigma <- function(X){
  alpha <- 0.05
  n <- length(X)
  x_sr <- mean(X)
  
  U <- sum((X - x_sr)^2) # (n-1)S^2
  
  sigma0 <- 2
  sigma0_2 <- sigma0^2
  
  ca <- ca_k
  cb <- cb_k
  
  decyzja <- 0
  if (U < ca | U > cb){
    decyzja <- 1 
  }
  
  return(decyzja)
}

#symulacja testu
mc <- 10000 
n <- 40
odrz <- c()

for (i in 1:mc){
  X <- rnorm(n, 0, 2) # generowanie próby N(0,2^2)
  odrz[i] <- TestSigma(X)
}

mean(odrz) 


sigma <- seq(1, 3, by=0.05) # sigma z przedziału [1,3]
moc <- c()

for (k in 1:length(sigma)){
  M <- c()
  for (i in 1:mc){
    X <- rnorm(n, 0, sigma[k]) # próba z N(0,sigma[k]^2) 
    M[i] <- TestSigma(X)       # badanie mocy dla różnych wartości sigma
  }
  moc[k] <- mean(M)
}

plot(sigma, moc, type='l')
abline(v=2, col="red", lty=2)



