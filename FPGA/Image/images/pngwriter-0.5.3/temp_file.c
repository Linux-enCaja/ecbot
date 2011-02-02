    if ((runLength > MIN_OBJECT_TRACKING_WIDTH)){			
      pTrackedObjectData = (unsigned char *)pCurrentTrackedObjectTable;
      for (i=0; i<MAX_TRACKED_OBJECTS; i++){
        if ( (currColor == *(pTrackedObjectData + COLOR_OFFSET)) && 
          (*(pTrackedObjectData + VALID_OBJECT_OFFSET) == TRUE) &&
          (*(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) == trackedLineCount - 1) &&
          /* add a check to limit the vertical size of object to 18 pixels */
          ((*(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) - (*(pTrackedObjectData + Y_UPPER_LEFT_OFFSET))) < 18) )                       
        {
          /* found a color match and the object is valid...check to see if there is connectedness */
          lastLineXStart = *(pTrackedObjectData + LAST_LINE_X_START_OFFSET);
          lastLineXFinish = *(pTrackedObjectData + LAST_LINE_X_FINISH_OFFSET);
          /* Check for the 5 following types of line connectedness:
           I.  ------    II.    -------   -----   III.    ---    ------ 
                  ------          ---    ----           -------  ------  */
          if ( ( (currPixelRunStart  >= lastLineXStart) && (currPixelRunStart  <= lastLineXFinish) ) ||  // I.
               ( (currPixelRunFinish >= lastLineXStart) && (currPixelRunFinish <= lastLineXFinish) ) ||  // II.
               ( (currPixelRunStart  <= lastLineXStart) && (currPixelRunFinish >= lastLineXFinish) ) )   // III.
          {
            /* THERE IS CONNECTEDNESS...update the lastLineXStart and lastLineXFinish
            data pointed to by pTrackedObjectData */
            *(pTrackedObjectData + LAST_LINE_X_START_OFFSET) = currPixelRunStart;
            *(pTrackedObjectData + LAST_LINE_X_FINISH_OFFSET) = currPixelRunFinish;
            /* check if the bounding box needs to be updated */
            if (*(pTrackedObjectData + X_UPPER_LEFT_OFFSET) > currPixelRunStart){
              *(pTrackedObjectData + X_UPPER_LEFT_OFFSET) = currPixelRunStart;
            }
            if ( *(pTrackedObjectData + X_LOWER_RIGHT_OFFSET) < currPixelRunFinish){
              *(pTrackedObjectData + X_LOWER_RIGHT_OFFSET) = currPixelRunFinish;
            }
            /* the lower right 'y' point always gets updated when connectedness is found */
            *(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) = trackedLineCount;
            colorConnected = TRUE;
            break;
          }
        }
        /* go to the next object */
        pTrackedObjectData += SIZE_OF_TRACKED_OBJECT;
      } // end for		
      if (colorConnected == FALSE){
        /* add a new entry to the tracking table, if there is space */
        if (numCurrTrackedObjects < MAX_TRACKED_OBJECTS){                
          pTrackedObjectData = (unsigned char *)pCurrentTrackedObjectTable;
          for (i=0; i<MAX_TRACKED_OBJECTS; ){
            if ( *(pTrackedObjectData + VALID_OBJECT_OFFSET) == FALSE)  break;
              pTrackedObjectData += SIZE_OF_TRACKED_OBJECT;
          }
          /* now that we have a pointer to the tracked object to be updated, update all the fields */
          *(pTrackedObjectData + COLOR_OFFSET)              = currColor;          /* color */
          *(pTrackedObjectData + LAST_LINE_X_START_OFFSET)  = currPixelRunStart; 	/* lastLineXStart */
          *(pTrackedObjectData + LAST_LINE_X_FINISH_OFFSET) = currPixelRunFinish;	/* lastLineXFinish */
          *(pTrackedObjectData + X_UPPER_LEFT_OFFSET)       = currPixelRunStart;  /* x_upperLeft */
          *(pTrackedObjectData + Y_UPPER_LEFT_OFFSET)       = trackedLineCount;   /* y_upperLeft */
          *(pTrackedObjectData + X_LOWER_RIGHT_OFFSET)      = currPixelRunFinish; /* x_lowerRight */
          *(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET)      = trackedLineCount;   /* y_lowerRight */
          *(pTrackedObjectData + VALID_OBJECT_OFFSET)       = TRUE;               /* objectValid flag */
          numCurrTrackedObjects++;
        }
      }
      /* move the pointer to the beginning of the next tracked object */
      pTrackedObjectData += SIZE_OF_TRACKED_OBJECT;
    } // end if














          lastLineXStart  = objects[i]->lastLineXStart;
          lastLineXFinish = objects[i]->lastLineXFinish;
          /* Check for the 5 following types of line connectedness:
           I.  ------    II.    -------   -----   III.    ---    ------ 
                  ------          ---    ----           -------  ------  */
          if ( ( (currPixel >= lastLineXStart) && (currPixel <= lastLineXFinish) ) ||  // I.
               ( (currPixel >= lastLineXStart) && (currPixel <= lastLineXFinish) ) ||  // II.
               ( (currPixel <= lastLineXStart) && (currPixel >= lastLineXFinish) ) )   // III.
          {

            /* THERE IS CONNECTEDNESS...update the lastLineXStart and lastLineXFinish */
            if (currPixel > currPixelRunStart){
              currPixelRunStart  = currPixel;
              currPixelRunFinish = currPixel;
            }
            else
              currPixelRunFinish = currPixel;
            start_detect == 1;

            /* check if the bounding box needs to be updated */
            if (objects[i]->x_upperLeft) > currPixelRunStart){
              objects[i]->x_upperLeft = currPixelRunStart;
            }
            if ( objects[i]->x_lowerRight) < currPixelRunFinish){
              objects[i]->x_lowerRight = currPixelRunFinish;
            }
            /* the lower right 'y' point always gets updated when connectedness is found */
            *(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) = trackedLineCount;
            colorConnected = TRUE;
            break;

