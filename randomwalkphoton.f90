Program randomwalkphoton

        !! variable & integer declarations !!
        IMPLICIT none
        REAL :: rand, xsum, xsqsum, seed
        INTEGER :: N, nwalks, i, j, x

        !! User input and assignment of N steps, and n walks !!
        Write(*,*)'Please enter the desired number of steps in the walk '
        Read(*,*)N
        Write(*,*)'Please enter the number of walks a photon should take '
        Read(*,*)nwalks
        Write(*,*)'Doing random photon walk to',N,'steps',nwalks,'times'

        !! I took advantage of a random number generator provided in the gfortran docs !!
        !! source: https://gcc.gnu.org/onlinedocs/gcc-5.1.0/gfortran/RANDOM_005fSEED.html#RANDOM_005fSEED
        CALL init_random_seed()

        !! xsum is the average position of a photon after N steps, should remain ~=0 !!
        xsum=0.0

        !! xsqsum is the average displacement of a photon after N steps, and should ~= N !!
        xsqsum=0.0

        !! Looping over n walks !!
        Open(10,FILE='randomwalkphoton.csv')
        Do i = 1, nwalks

                !! Start a new walk once N steps from previous walk are over !!
                x = 0

                !! Looping over N steps for this particular walk i !!
                do  j=1,N

                       !! Generate a random number between 0 and 1 !!
                        CALL RANDOM_NUMBER(rand)
                        seed=rand

                        !! The idea here is that we randomly determine which direction to walk !!
                        if (seed<0.5) then

                                !! Walk down !!
                                x=x-1
                        else
                                !! Walk up !!
                                x=x+1
                        endif
                                Write(10,*)i,x

                enddo
                !! Calculate average position for this walk !!
                xsum=xsum+x

                !! Calculate average displacement for this walk !!
                xsqsum=xsqsum+x*x

        enddo
        Close(10)

        !! Output the average position/nwalks and average displacement/nwalks for a photon !!
        Write(*,*)"<x(N)> is ", xsum/nwalks, "<x2(N)> is ", xsqsum/nwalks

        !! UNCOMMENT TO WRITE TO A FILE CALLED randomwalkphoton.output !!
        !Open(10,FILE='randomwalkphoton.output')
        !Write(10,*)"<x(N)> ",xsum/nwalks," <x2(N)> ",xsqsum/nwalks
        !Close(10)

End Program randomwalkphoton
