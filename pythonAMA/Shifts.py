# This file contains the following functions:
#          Exact_shift, Numeric_shift, Shiftright

# Original author: Gary Anderson
# Original file downloaded from:
# http://www.federalreserve.gov/Pubs/oss/oss4/code.html
# Adapted for Dynare by Dynare Team.

# This code is in the public domain and may be used freely.
# However the authors would appreciate acknowledgement of the source by
# citation of any of the following papers:

# Anderson, G. and Moore, G.
# "A Linear Algebraic Procedure for Solving Linear Perfect Foresight
# Models."
# Economics Letters, 17, 1985.

# Anderson, G.
# "Solving Linear Rational Expectations Models: A Horse Race"
# Computational Economics, 2008, vol. 31, issue 2, pages 95-113

# Anderson, G.
# "A Reliable and Computationally Efficient Algorithm for Imposing the
# Saddle Point Property in Dynamic Models"
# Journal of Economic Dynamics and Control, 2010, vol. 34, issue 3,
# pages 472-489


# Import the numpy and scipy packages
import numpy
import scipy

##########################################################################


def Shiftright(x,n):

    #  Shift the rows of x to the right by n columns, leaving zeros in the
    #  first n columns. 
    
    rows, cols = x.shape
    left  = 0:cols-n
    right = n:cols
    
    y = numpy.matrix(numpy.zeros(shape=((rows,cols))))
    y(:,right) = x(:,left)
    
    return y

##########################################################################


def Exact_shift(h,q,iq,qrows,qcols,neq):

    # Compute the exact shiftrights and store them in q.

    hs = scipy.sparse.csr_matrix(h)
    nexact = 0
    left   = 0:qcols
    right  = qcols:qcols+neq
    zerorows = list()
    sumVector = numpy.absolute(hs(:,right).T).sum(axis=1)
    for i in range(0,len(sumVector)):
        if sumVector[i] == 0:
            zerorows.append(i)

    while len(zerorows) > 0  and iq <= qrows:
        nz = len(zerorows)
        q(iq:iq+nz,:) = hs(zerorows,left)
        hs(zerorows,:) = Shiftright( hs(zerorows,:),neq )
        iq = iq + nz
        nexact = nexact + nz
        zerorows = list()
        newSumVector = numpy.absolute(hs(:,right).T).sum(axis=1)
        for i in range(0,len(newSumVector)):
            if newSumVector[i] == 0:
                zerorows.append(i)
        h = scipy.sparse.csr_matrix.todense(hs)
        
    return h, q, iq, nexact

#########################################################################

def Numeric_shift(h,q,iq,qrows,qcols,neq,condn):

    # Compute the numeric shiftrights and store them in q.
    
    nnumeric = 0
    left     = 0:qcols
    right    = qcols:qcols+neq
    
    Q, R, P  = scipy.linalg.qr(h(:,right))
    zerorows = list()
    testVector = abs(numpy.diagonal(R))
    for i in range(0,len(testVector)):
        if testVector[i] <= condn:
            zerorows.append(i)
    
    while len(zerorows) > 0 and iq <= qrows:
        h = scipy.sparse.csr_matrix(h)
        Q = scipy.sparse.csr_matrix(Q)
        h = Q.T * h
        nz = len(zerorows)
        q(iq:iq+nz,:) = h(zerorows,left)
        h(zerorows,:) = Shiftright( h(zerorows,:), neq )
        iq = iq + nz
        nnumeric = nnumeric + nz
        Q, R, P  = scipy.linalg.qr(scipy.sparse.csr_matrix.todense(h(:,right)))
        zerorows = list()
        testVector = abs(numpy.diagonal(R))
        for i in range(0,len(testVector)):
            if testVector[i] <= condn:
                zerorows.append(i)
                
    return h, q, iq, nnumeric

