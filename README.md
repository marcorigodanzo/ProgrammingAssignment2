### Introduction

`cacheSolve` is a function that is able to cache potentially time-consuming computations.

It must be fed with a cache matrix object created via the makeCacheMatrix function  

The function takes advantage of the scoping rules of the R language 
to preserve state inside of an R object.

###  Caching the Inverse of a Matrix

The first function, `cacheSolve` creates a special "matrix", which is
really a list containing a function to

1.  set the value of the matrix
2.  get the value of the matrix
3.  set the value of the inverse
4.  get the value of the inverse

<!-- -->

    makeCacheMatrix <- function(x = matrix()) {
        ## variables
        ## m_inverse contains the cached inverse, it is initialized as NULL
        
        m_inverse <- NULL
        
        ## setter function
        set <- function(y) {
            x <<- y
            m_inverse <<- NULL
        }
        
        ## getter function
        get <- function() x
        
        ## set inverse
        setinverse <- function(inverse) m_inverse <<- inverse
        
        ## get inverse
        getinverse <- function() m_inverse
        
        ## Creates a list with the getter and setter functions
        ## plus the getter and setter functions for the inverse
        
        print(x)
        
        invisible(list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse))
        
    }

The following function calculates the inverse of the special "matrix"
created with the above function. However, it first checks to see if the
inverse has already been calculated. If so, it `get`s the inverse from the
cache and skips the computation. Otherwise, it calculates the inverse of
the data and sets the value of the mean in the cache via the `getinverse`
function.

    cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m_inverse <- x$getinverse()
        if(!is.null(m_inverse)) {
            message("getting cached data")
            return(m_inverse)
        }
        data <- x$get()
        m_inverse <- solve(data, ...)
        x$setinverse(m_inverse)
        m_inverse
        
    }


