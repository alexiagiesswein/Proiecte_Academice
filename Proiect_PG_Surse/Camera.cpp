#include "Camera.hpp"
#include<iostream>

namespace gps {

    //Camera constructor
    Camera::Camera(glm::vec3 cameraPosition, glm::vec3 cameraTarget, glm::vec3 cameraUp) {
        //TODO
        this->cameraPosition = cameraPosition;
        this->cameraTarget = cameraTarget;
        this->cameraUpDirection = cameraUp;

        this->cameraFrontDirection = glm::normalize(cameraTarget - cameraPosition);  // z-axis
        // corss product of two vectors get another perpenticular on both
        this->cameraRightDirection = glm::normalize(glm::cross(cameraFrontDirection, cameraUpDirection));

    }

    //return the view matrix, using the glm::lookAt() function
    glm::mat4 Camera::getViewMatrix() {
        //TODO
        //camera position, target position, the up direction 
        return glm::lookAt(cameraPosition, (cameraPosition + cameraFrontDirection), cameraUpDirection);
    }

    //update the camera internal parameters following a camera move event
    void Camera::move(MOVE_DIRECTION direction, float speed) {
        //TODO
        switch (direction)
        {
        case MOVE_FORWARD:
            cameraPosition += cameraFrontDirection * speed;
            break;
        case MOVE_BACKWARD:
            cameraPosition -= cameraFrontDirection * speed;
            break;
        case MOVE_RIGHT:
            cameraPosition += cameraRightDirection * speed;
            break;
        case MOVE_LEFT:
            cameraPosition -= cameraRightDirection * speed;
            break;
        }
    }

    void Camera::printPos() {
        std::cout << cameraPosition.x << " " << cameraPosition.y << " " << cameraPosition.z << " ";
    }

    //update the camera internal parameters following a camera rotate event
    //yaw - camera rotation around the y axis
    //pitch - camera rotation around the x axis
    void Camera::rotate(float pitch, float yaw) {
        //TODO
        glm::vec3 auxVector;
        auxVector.x = cos(glm::radians(yaw)) * cos(glm::radians(pitch));
        auxVector.y = sin(glm::radians(pitch));
        auxVector.z = sin(glm::radians(yaw)) * cos(glm::radians(pitch));
        cameraFrontDirection = glm::normalize(auxVector);
        cameraRightDirection = glm::normalize(glm::cross(cameraFrontDirection, cameraUpDirection));
    }

    void Camera::animatie() {
        cameraPosition.x = 128.977f;
        cameraPosition.y = -73.27f;
        cameraPosition.z = -16.35f;
    }


    void Camera::inainte() {
        if (cameraPosition.x >= 66.13f) {
            cameraPosition.x -= 0.25f;
           // cameraPosition.y -= 1.0f;
            cameraPosition.z += 1.0f;
        }
    }

    glm::vec3 Camera::cameraPos() {
        return cameraPosition;
    }
}