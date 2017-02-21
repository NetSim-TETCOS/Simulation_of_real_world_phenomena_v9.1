function WSN = NetSim_MATLAB_RUN(simulation_time, event_time,current_time,flag)
clc;
close;
rng(1) ;

if (flag==0)%sensor is sensing the signal
    if (event_time==0)
        t=(0:0.1:simulation_time)';
        x = sawtooth(t);% This is the sawtooth signal f(t)
        y = awgn(x,1,'measured');% This is additive white gaussian noise 
    end
    %f(t) and noise at every event
    x1 = sawtooth(event_time);
    y1 = awgn(x1,1,'measured');
    a = y1;
    disp(a);
    fileID1 = fopen('sensor.txt','A');
    fprintf(fileID1,'%f %f\r\n',event_time,a);
    fclose (fileID1); 
    WSN = a;
end

if(flag == 1)%signal received at sink
    x2=sawtooth(current_time);    
    y2=awgn(x2,1,'measured');
    fileID2 = fopen('sink.txt','A');
    fprintf(fileID2,'%f %f\r\n',current_time,y2);
    fclose (fileID2);       
end

if (flag == 2)
    fileID1 = fopen('sensor.txt','A');
    fprintf(fileID1,'%f %f\r\n',simulation_time,0);
    fclose (fileID1); 
    fileID1 = fopen('sink.txt','A');
    fprintf(fileID1,'%f %f\r\n',simulation_time,0);
    fclose (fileID1); 
    fileID1 = fopen('sensor.txt');
    sensor = textscan(fileID1,'%f %f');
    fclose(fileID1);
    fileID2 = fopen('sink.txt');
    sink = textscan(fileID2,'%f %f');
    fclose(fileID2);      
    %Graphs plotting
    figure   
    t=(0:0.1:simulation_time)';
    x = sawtooth(t);
    y = awgn(x,1,'measured');
    subplot(4,1,1)
    plot(t,x)
    title('Real phenomena modeled as f(t) = sawtooth(t)')
    subplot(4,1,2)
    plot(t,[x y])
    title('g(t) modeled as f(t) + Noise')
    subplot(4,1,3)
    plot(sensor{1},sensor{2},'*') 
    title('Sensed signal at sensor')
    subplot(4,1,4)
    plot(sink{1},sink{2},'*')       
    title('Received signal at sink')
    delete('sensor.txt');
    delete('sink.txt');
end   
  end 
