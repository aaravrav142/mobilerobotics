function[]=plot_fs(pose,map,y,muFeatNew,particleSet,t,meas_ind,totalParticles,noFeatures,newfeature,centroid_particles)
        %Color Map Intialization
        cmap = colormap('jet');
        cmap = cmap(1:3:end,:);
        cn = length(cmap(:,1));
        figure(1);clf; hold on;
        %Plot the Robot Pose
        plot(pose(1,1:t),pose(2,1:t), 'ro--')
        % Draw the Heading
        plot([pose(1,t) pose(1,t)+1*cos(pose(3,t))],[pose(2,t) pose(2,t)+1*sin(pose(3,t))], 'r-')
        %Differentiate the currently Observed Features by drawing a line
        for j=1:length(meas_ind)
            plot([pose(1,t) pose(1,t)+y(1,j)*cos(y(2,j)+pose(3,t))], [pose(2,t) pose(2,t)+y(1,j)*sin(y(2,j)+pose(3,t))], 'Color', cmap(mod(meas_ind(j),cn)+1,:) );
        end
        % Plot the Map
        for j = 1:noFeatures
            plot(map(1,j),map(2,j),'o','Color', cmap(mod(j,cn)+1,:), 'MarkerSize',10,'LineWidth',2);
        end
        %Draw the Particles
        for d=1:totalParticles
            plot(particleSet(1,d),particleSet(2,d),'b.');
            for j = 1:noFeatures
                if (~newfeature(j))
                    plot(muFeatNew(1,j,d),muFeatNew(2,j,d),'.','Color', cmap(mod(j,cn)+1,:));
                end
            end
        end
        %Plot Centroid of Particles
        plot(centroid_particles(1,1:t),centroid_particles(2,1:t), 'g*');

        %Define Axes
        axis equal
        axis([-8 8 -2 10])
        title('FastSLAM with Range & Bearing Measurements')
        pause(0.001);%Pause to let MATLAB plot and display the results
    end