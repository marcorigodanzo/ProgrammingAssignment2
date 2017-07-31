## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

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


## This function returns the inverse of the matrix stored in the CacheMatrix object
## If the inverse is cached then it returns the value from the cache, otherwise it calculates the inverse

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
