
images = {'image2.png', 'image3.png', 'image4.png'};

img1 = imread('image1.png');
BWa = im2bw(img1);
[B1, L1] = bwboundaries(BWa,'noholes');
disp(B1);

for m = 1:length(images)
    fileName = images{m};
    disp(fileName);
    img2 = imread(fileName);
    BWb = im2bw(img2);
    [B2, L2] = bwboundaries(BWb,'noholes');
    dist = hausdorffDist(B1{1},B2{1});
    disp(dist);
end

function [ H ] = hausdorffDist(P,Q)
    D = pdist2(P,Q);
    hab = max(min(D,[],2));% Directed from a to b
    hba = max(min(D));% Directed from b to a
    H = max([hab,hba]);

    % visualize the data
        figure
        subplot(1,1,1)
        hold on
        axis equal
        
        % data for plotting
        [mp ixp] = min(D,[],2);
        [mq ixq] = min(D,[],1);
        [mp ixpp] = max(mp);
        [mq ixqq] = max(mq);
        [m ix] = max([mq mp]);
        if ix==2
            ixhd = [ixp(ixpp) ixpp];
            xyf = [Q(ixhd(1),:); P(ixhd(2),:)];
        else
            ixhd = [ixqq ixq(ixqq)];
            xyf = [Q(ixhd(1),:); P(ixhd(2),:)];
        end
        
            h(1) = plot(P(:,1),P(:,2),'b','markersize',10,'linewidth',3);
            h(2) = plot(Q(:,1),Q(:,2),'r','markersize',8,'linewidth',2.5);
            
            % denote the hausdorff distance
            h(3) = plot(xyf(:,1),xyf(:,2),'-ks','markersize',12,'linewidth',2);
            uistack(fliplr(h),'top')
            xlabel('Dim 1'); ylabel('Dim 2');
            title(['Hausdorff Distance = ' num2str(m)])
            legend(h,{'P','Q','Hausdorff Dist'},'location','best')
end
